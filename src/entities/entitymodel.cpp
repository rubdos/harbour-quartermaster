#include "entitymodel.h"

EntityModel::EntityModel(QObject *parent) :
    QAbstractListModel(parent),
    m_loading(false)
{

}

EntityModel::~EntityModel()
{
    qDeleteAll(m_entities.begin(), m_entities.end());
}

QList<Entity *> EntityModel::entities() const
{
    return m_entities;
}

bool EntityModel::isEmpty() const
{
    return m_entities.isEmpty();
}

void EntityModel::addEntity(Entity *entity)
{
    if (!entity)
        return;

    beginInsertRows(QModelIndex(), m_entities.count(), m_entities.count());
    m_entities.append(entity);
    endInsertRows();
}

void EntityModel::setEntities(const QList<Entity *> &entities)
{
    beginResetModel();
    beginResetModel();
    qDeleteAll(m_entities.begin(), m_entities.end());
    m_entities.clear();
    m_entities = entities;
    endResetModel();
    endResetModel();
}

void EntityModel::updateEntity(Entity *entity)
{
    if (!entity)
        return;
}

bool EntityModel::loading() const
{
    return m_loading;
}

void EntityModel::reset()
{
    beginResetModel();
    qDeleteAll(m_entities.begin(), m_entities.end());
    m_entities.clear();
    endResetModel();
}

void EntityModel::setLoading(bool loading)
{
    if (m_loading == loading)
        return;

    m_loading = loading;
    emit loadingChanged(m_loading);
}

int EntityModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)

    return m_entities.count();
}

QVariant EntityModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    Entity *entity = m_entities.at(index.row());

    switch (role) {
    case Qt::DisplayRole:
        return entity->name();

    case NameRole:
        return entity->name();

    case AttributesRole:
        return entity->attributes();

    case ContextRole:
        return QVariant::fromValue<EntityContext>(entity->context());

    case EntityIdRole:
        return entity->enityId();

    case StateRole:
        return entity->state();

    case TypeRole:
        return int(entity->type());

    default:
        return QVariant();
    }
}

QHash<int, QByteArray> EntityModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[AttributesRole]   = "attributes";
    roles[ContextRole]      = "context";
    roles[EntityIdRole]     = "entity_id";
    roles[NameRole]         = "name";
    roles[StateRole]        = "state";
    roles[TypeRole]         = "type";

    return roles;
}
